concurrency baked-in

### **Basic types**
#### ***Numbers***
uint8       the set of all unsigned  8-bit integers (0 to 255)
uint16      the set of all unsigned 16-bit integers (0 to 65535)
uint32      the set of all unsigned 32-bit integers (0 to 4294967295)
uint64      the set of all unsigned 64-bit integers (0 to 18446744073709551615)

int8        the set of all signed  8-bit integers (-128 to 127)
int16       the set of all signed 16-bit integers (-32768 to 32767)
int32       the set of all signed 32-bit integers (-2147483648 to 2147483647)
int64       the set of all signed 64-bit integers (-9223372036854775808 to 9223372036854775807)

float32     the set of all IEEE-754 32-bit floating-point numbers
float64     the set of all IEEE-754 64-bit floating-point numbers

complex64   the set of all complex numbers with float32 real and imaginary parts
complex128  the set of all complex numbers with float64 real and imaginary parts

byte        alias for uint8
rune        alias for int32 (code point)

uint     either 32 or 64 bits
int      same size as uint
uintptr  an unsigned integer large enough to store the uninterpreted bits of a pointer value

#### **Strings**
- string: a read-only slice of bytes, a string holds arbitrary bytes

- To summarize, strings can contain arbitrary bytes, but when constructed from string literals, those bytes are (almost always) UTF-8.

- for range loop, by contrast, decodes one UTF-8-encoded rune on each iteration.Index string yield bytes.

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
x := make([]int, 4, 7)
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
#re-slicing a slice doesn't make a copy of the underlying array. The full array will be kept in memory until it is no longer referenced

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

### **closures**

### **compare**

comparable types are boolean, numeric, string, **pointer**, **channel**, and **interface** types, and **structs** or **arrays** that contain only those types. Notably absent from the list are slices, maps, and functions

### **goroutines**

### **errors**
`if errors.Is(err, os.ErrExist)` is preferable to `if err == os.ErrExist`

```
var perr *os.PathError
if errors.As(err, &perr) {
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


### ????
slice append understand



