concurrency baked-in

### **Basic types**
#### ***Numbers***
- uint8       the set of all unsigned  8-bit integers (0 to 255)
- uint16      the set of all unsigned 16-bit integers (0 to 65535)
- uint32      the set of all unsigned 32-bit integers (0 to 4294967295)
- uint64      the set of all unsigned 64-bit integers (0 to 18446744073709551615)

- int8        the set of all signed  8-bit integers (-128 to 127)
- int16       the set of all signed 16-bit integers (-32768 to 32767)
- int32       the set of all signed 32-bit integers (-2147483648 to 2147483647)
- int64       the set of all signed 64-bit integers (-9223372036854775808 to 9223372036854775807)

- float32     the set of all IEEE-754 32-bit floating-point numbers
- float64     the set of all IEEE-754 64-bit floating-point numbers

- complex64   the set of all complex numbers with float32 real and imaginary parts
- complex128  the set of all complex numbers with float64 real and imaginary parts

- byte        alias for uint8
- rune        alias for int32 (code point)

- uint     either 32 or 64 bits
- int      same size as uint
- uintptr  an unsigned integer large enough to store the uninterpreted bits of a pointer value

#### ***Strings***
- string: a read-only slice of bytes, a string holds arbitrary bytes

- To summarize, strings can contain arbitrary bytes, but when constructed from string literals, those bytes are (almost always) UTF-8.

- Index string yield bytes
- for range loop, by contrast, decodes one UTF-8-encoded rune on each iteration.

```
	const sample = "\xbd\xb2\x3d\xbc\x20\xe2\x8c\x98"

	fmt.Printf("%+q\n", sample)
	fmt.Printf("% x\n", sample)
	fmt.Printf("%s\n", sample)
	for i := 0; i < len(sample); i++ {
		fmt.Printf("%s ", string(sample[i]))
	}
	fmt.Println()
	for i := 0; i < len(sample); i++ {
		fmt.Printf("%d ", sample[i])
	}
	fmt.Println()

	const nihongo = "日本語"
	const nihongo1 = "\xe6\x97\xa5"
	for index, runeValue := range nihongo {
		fmt.Printf("%#U starts at byte position %d\n", runeValue, index)
	}
	fmt.Printf("%s\n", nihongo)
	fmt.Println(nihongo1)
	for i := 0; i < len(nihongo); i++ {
		fmt.Printf("%+q ", (nihongo[i]))
	}
	fmt.Println()
	for i := 0; i < len(nihongo); i++ {
		fmt.Printf("%s ", string(nihongo[i]))
	}
```
### **composite types**
#### ***arrays***

- Go's arrays are values. One way to think about arrays is as a sort of struct but with indexed rather than named fields: a fixed-size composite value.

#### ***slices***
- `func make([]T, len, cap) []T`; zero value of slice is nil; reference type  
- growing an slice: create a new, larger one; 
```
func copy(dst, src []T) int
x := make([]int, 4, 7) //cap(x)=7, len(x)=4
y := make([]int, 5)
x = x[:cap(x)]


func Filter(s []int, fn func(int) bool) []int {
    var p []int // == nil
    for _, v := range s {
        if fn(v) {
            p = append(p, v)
        }
    }
    return p
}
```
- re-slicing a slice doesn't make a copy of the underlying array. The full array will be kept in memory until it is no longer referenced
```
func CopyDigits(filename string) []byte {
    b, _ := ioutil.ReadFile(filename)
    b = digitRegexp.Find(b)
    c := make([]byte, len(b))
    copy(c, b)
    return c
}
```
#### ***maps***
- attempts to write to a nil map will cause a runtime panic
- make; map literals; zero values; nested

```
# This is preferable to hits := make(map[string]map[string]int)
type Key struct {
    Path, Country string
}
hits := make(map[Key]int)
hits[Key{"/", "vn"}]++
```
- not thread-safe
```
var counter = struct{
    sync.RWMutex
    m map[string]int
}{m: make(map[string]int)}
counter.RLock()
n := counter.m["some_key"]
counter.RUnlock()
fmt.Println("some_key:", n)

counter.Lock()
counter.m["some_key"]++
counter.Unlock()
```
- not in guaranteed order
```
import "sort"

var m map[int]string
var keys []int
for k := range m {
    keys = append(keys, k)
}
sort.Ints(keys)
for _, k := range keys {
    fmt.Println("Key:", k, "Value:", m[k])
}
delete(m, somekey)
```
#### ***struct***

- Go automatically handles conversion between values and pointers for method calls

```
type Circle struct {
 x, y, r float64
}
func circleArea(c *Circle) float64 {
 return math.Pi * c.r*c.r
}
func (c *Circle) area() float64 {
 return math.Pi * c.r*c.r
}
c := Circle{0, 0, 5}
fmt.Println(circleArea(&c))
fmt.Println(c.area()) //(Go automatically knows to pass a pointer to the circle for this method

```
- embedded types
is-a relationship
```
type Person struct {
 Name string
}
func (p *Person) Talk() {
 fmt.Println("Hi, my name is", p.Name)
}
type Android struct {
 Person
 Model string
}
a := new(Android)
a.Person.Talk()
a.Talk()
```
### Interfaces
- focus more on the behavior of your program than on a taxonomy of types

### **formatting print**

%v, %T, %x, %q, %s

### **declare and assign**
explicit type (int, float64 for numbers)
zero value  
```
var c, python, java = true, false, "no!"
```
### **for, if/else, switch**
- There is no tenary if in go
- default is optional; could use commas to separate multiple expressions in the same case statement; switch without expression
- type switch
```
whatAmI := func(i interface{}) {
        switch t := i.(type) {
        case bool:
            fmt.Println("I'm a bool")
        case int:
            fmt.Println("I'm an int")
        default:
            fmt.Printf("Don't know type %T\n", t)
        }
    }
```
### functional programming
- **closures**
```
func makeEvenGenerator() func() uint {
 i := uint(0)
 return func() (ret uint) {
 ret = i
 i += 2
 return
 }
}
func main() {
 nextEven := makeEvenGenerator()
 fmt.Println(nextEven()) // 0
 fmt.Println(nextEven()) // 2
 fmt.Println(nextEven()) // 4
}
```
- **recursion**

### **compare**

comparable types are boolean, numeric, string, **pointer**, **channel**, and **interface** types, and **structs** or **arrays** that contain only those types. Notably absent from the list are slices, maps, and functions

### **goroutines**

### **errors**
`if errors.Is(err, os.ErrExist)` is preferable to `if err == os.ErrExist`

```
var perr *os.PathError
if errors.As(err, perr) {
	fmt.Println(perr.Path)
}
```
is preferable to
```
if perr, ok := err.(*os.PathError); ok {
	fmt.Println(perr.Path)
}
```
```
func New(text string) error
type error interface {
    Error() string
}
```
### defer, panic
- keeps Close call near Open call
- If function had multiple return statements Close will happen before both of them.
- Deferred functions are run even if a runtime panic occurs.

### miscs
- slice append understand
- arguments were always copied in go
- package speed up the compiler by only requiring recompilation of smaller chunks of a
program.
- godoc
```
godoc -http=":6060"```
go doc <package> <method>
godoc -http=":6060"```

### packages
- fmt
```
var input string
fmt.Scanln(&input)
```
- strings
```
strcov.Itoa(s string) int, Error
strconv.Atoi(int) string
strings.count(s1, s2 string) int
strings.HasPrefix(s1, s2 string) bool
strings.HasSuffix(s1, s2 string) bool
strings.Index(s1, s2 string) int
strings.Join(arr []string, delimiter string) string
strings.Split("a-b-c-d-e", "-")
strings.Replace("aaaa", "a", "b", 2) //bbaa, use -1 to replace all occurences
strings.ToLower("TEST")
strings.ToUpper("test")
strings.Repeat("a", 5)
```
- io package
- RPC, **http**, tcp, flag
```
var buf bytes.Buffer
buf.Write([]byte("test"))
```
- create our own
import (full path, not worrying about naming collisions)
package name matches the folder they fall in (mostly)

### unit test

### resources
- https://golang.org/src/




