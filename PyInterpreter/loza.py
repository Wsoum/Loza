import interpreter
import sys

if len(sys.argv) >= 2: 
    text="run(\""+sys.argv[1]+"\")"
    result, error = interpreter.run('<stdin>', text)

    if error:
        print(error.as_string())
    elif result:
        if len(result.elements) == 1:
            print(repr(result.elements[0]))
        else:
            print(repr(result))
else:
    while True:
        text = input('loza > ')
        if text.strip() == "": continue
        result, error = interpreter.run('<stdin>', text)

        if error:
            print(error.as_string())
        elif result:
            if len(result.elements) == 1:
                print(repr(result.elements[0]))
            else:
                print(repr(result))