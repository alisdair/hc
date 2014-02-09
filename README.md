# hc

hc is a command-line RPN calculator tool. It is very simple.

This code was produced in a two-hour Haskell pairing session with [@kubkon](https://github.com/kubkon).

## Usage

    $ hc 4 5 + 3 \*
    27

    $ hc 4 5 3 +
    hc: Operator missing

    $ hc 4 +
    hc: Stack underflow

## Tips

If you're using zsh, try this alias in your ~/.zshrc:

    alias hc="noglob hc"

With it in place, you don't have to escape \*.

If you're using bash, I feel bad for you.

## License

MIT.

Written by Alisdair McDiarmid and Jakub Konka.
