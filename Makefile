.PHONY: all
all: hc

hc: Main.hs
	ghc -o $@ $^

.PHONY: clean
clean:
	rm -f hc *.hi *.o
