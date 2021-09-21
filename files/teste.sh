source files/functions.sh

main()
{
    echo "hello"
    bind_install "uma frase"
}

APP1="1.1.1.1"
APP2="2.2.2.2"
APPs="$APP1 $APP2"
for APP in $APPs; do
    echo "$APP"
done

main
