package main

import (
	"io"
	"net/http"
	"html/template"
	"os"
	"os/exec"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
)

var (
	BUF_LEN = 1024
)

var tmpl = template.Must(template.New("tmpl").ParseFiles("index.html"))

type conf struct {
	Device  string `yaml:"device"`
	Distro  string `yaml:"distro"`
	Arch	string `yaml:"arch"`
	Branch	string `yaml:"branch"`
	Desktop string `yaml:"desktop"`
}

func (c *conf) getConf() *conf {

	yamlFile, err := ioutil.ReadFile("img.yml")
	if err != nil {
		log.Printf("yamlFile.Get err   #%v ", err)
	}
	err = yaml.Unmarshal(yamlFile, c)
	if err != nil {
		log.Fatalf("Unmarshal: %v", err)
	}

	return c
}

func BuildHandler(w http.ResponseWriter, r *http.Request) {
	var c conf
	conf:=c.getConf()

	os.Setenv("DEVICE", conf.Device)
	os.Setenv("DISTRO", conf.Distro)
	os.Setenv("ARCH", conf.Arch)
	os.Setenv("BRANCH", conf.Branch)
	os.Setenv("DESKTOP", conf.Desktop)

	cmd := exec.Command("make", "image")
	pipeReader, pipeWriter := io.Pipe()
	cmd.Stdout = pipeWriter
	cmd.Stderr = pipeWriter
	go writeCmdOutput(w, pipeReader)
	cmd.Run()
	pipeWriter.Close()
}

func writeCmdOutput(res http.ResponseWriter, pipeReader *io.PipeReader) {
	buffer := make([]byte, BUF_LEN)
	for {
		n, err := pipeReader.Read(buffer)
		if err != nil {
			pipeReader.Close()
			break
		}

		data := buffer[0:n]
		res.Write(data)
		if f, ok := res.(http.Flusher); ok {
			f.Flush()
		}
		//reset buffer
		for i := 0; i < n; i++ {
			buffer[i] = 0
		}
	}
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
        if err := tmpl.ExecuteTemplate(w, "index.html", nil); err != nil {
                http.Error(w, err.Error(), http.StatusInternalServerError)
        }
}

func main() {
	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/build", BuildHandler)
	http.Handle("/dl/", http.StripPrefix("/dl/", http.FileServer(http.Dir("./target"))))
	http.ListenAndServe(":8080", nil)
}
