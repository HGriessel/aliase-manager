#bin/bash
# n,f,c,
# p port range ie 7000

exit_on_error() {
    exit_code=$1
    error_msg=$2
    if [ $exit_code -ne 0 ]; then
        >&2 printf "\n\nCommand failed with exit code: \n\n $error_msg \n\n" 
        exit $exit_code
    fi
}

#TODO add single aliase to specfic aliase file
#generate_ranmdom_port_range(){}
#remove_spec_char(){}
#remove_space_char(){}



while getopts n:c:f:p flag
do
    case "${flag}" in
        n) is_newfile=${OPTARG};;
        f) filename=${OPTARG};;
        c) customer_name=${OPTARG};;
    esac
done

#customer name has to bed defined
if [ -z "$customer_name" ]
then
error_message='Customer Name has to be defined with -c flag ie makealias -c CustomerName'
exit_on_error 1 "$error_message"
fi


# default new file to true
if [ -z "$is_newfile" ]
then
is_newfile=1
fi

# default filename to customer name
if [ -z "$filename" ]
then
    #TODO add check for customer name contains 
    filename=".zsh$customer_name"
else
    if [[ $filename == *"zsh"* ]]
    then
        echo "filename cool"
    else
        filename=".zsh$filename"
    fi
    
fi

aliase_file_text="
#$customer_name
alias  edit$customer_name='nano ~/.zshaliases/$filename'
source ~/.zshaliases/$filename"

echo "$aliase_file_text" >> .zshalias
echo "#$customer_name" >> ~/.zshaliases/$filename

echo "is_newfile: $is_newfile";
echo "filename: $filename";
echo "Customer Name: $customer_name";
