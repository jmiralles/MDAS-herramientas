greeting="hello mdas, $1, $2"

if cp ./hola hola; then
    echo "RESULT $?"
    echo $greeting
else
    echo "RESULT $?"        
fi

cp ./hola hola || true
echo $greeting
