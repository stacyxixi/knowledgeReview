### REST
an architecture style
decouple consumers/client and producer/server
https://www.restapitutorial.com/lessons/whatisrest.html#
- uniform interface
- stateless
- cacheable
- client-server
- layered system
- code on demand

### golang

http
https://tutorialedge.net/golang/creating-restful-api-with-golang/
```
gorilla/mux
myRouter := mux.NewRouter().StrictSlash(true)
myRouter.HandleFunc("/", homePage).Methods("POST"/"GET"/"PUT")

fmt.Fprintf(w, "%+v", x)
vars := mux.Vars(r)
key := vars["id"]

reqBody, _ := ioutil.ReadAll(r.Body)
var article Article 
json.Unmarshal(reqBody, &article)
json.NewEncoder(w).encode(x)
```

ioutil
