read -p "show version? [y/n]: " showVersion

if [ "${showVersion,,}" != "y" ] && [ "${showVersion,,}" != "n" ]; then
    echo "input y or n!"
    exit -1
fi

read -p "image tag: " dockerTag

sudo docker run --rm -t -v $(pwd)/php/list_extensions.php:/list_extensions.php "${dockerTag}" php /list_extensions.php "${showVersion,,}"