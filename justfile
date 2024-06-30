default: run

run:
    pack run idre2.ipkg

fast-run ARGS="":
    ./build/exec/idre2 {{ARGS}}

test:
    pack test idre2


