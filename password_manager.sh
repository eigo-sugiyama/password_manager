#step3
echo
echo パスワードマネージャーへようこそ！
echo
echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
echo
select input in "Add Password" "Get Password" "Exit"
do
case "$input" in
    "Add Password")
        echo
        read -p "サービス名を入力してください： " set_service_name
        read -p "ユーザー名を入力してください： " set_user_name
        read -p "パスワードを入力してください： " set_password
        # 入力情報の暗号化
        gpg --batch --yes --decrypt --output /tmp/secrets_decrypted.txt secrets.gpg
        echo "$set_service_name,$set_user_name,$set_password" >> /tmp/secrets_decrypted.txt
        gpg --batch --yes --encrypt --recipient 'eigo.sugiyama0403@gmail.com' --output secrets.gpg /tmp/secrets_decrypted.txt
        rm /tmp/secrets_decrypted.txt
        echo
        echo パスワードの追加は成功しました。
        echo
        ;;

    "Get Password")
        echo
        read -p "サービス名を入力してください： " get_service_name
        echo
        gpg --decrypt --output /tmp/secrets_decrypted.txt secrets.gpg 
        # 保存情報の複合化 - 合致するサービス名の行を検索して表示
        while IFS=, read -r name user password; do
            if [ "$name" == "$get_service_name" ]; then
                answer="Service Name: $name\nUser Name: $user\nPassword: $password"
                break
            fi
        done < /tmp/secrets_decrypted.txt
        rm /tmp/secrets_decrypted.txt
        if [ "$answer" == "" ]; then
            echo
            echo "指定されたサービスの情報は見つかりませんでした。"
            echo
        else
            echo
            echo -e "$answer"
            echo
        fi
        ;;

    "Exit")
        break
        ;;

    *)  
        echo
        echo "誤入力です。Add Password/Get Password/Exit から番号で入力してください。"
        echo
        ;;
esac
done