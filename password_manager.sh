#step3
echo パスワードマネージャーへようこそ！
echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
select input in "Add Password" "Get Password" "Exit"
do
case "$input" in
    "Add Password")
        echo
        echo パスワードマネージャーへようこそ！
        echo
        read -p "サービス名を入力してください： " set_service_name
        read -p "ユーザー名を入力してください： " set_user_name
        #パスワードを表示させたくなければ、-pオプション
        #read -s -p "パスワードを入力してください： " set_password
        read -p "パスワードを入力してください： " set_password
        yes | gpg --batch --yes --decrypt --output /tmp/secrets_decrypted.txt secrets.gpg
        echo "$set_service_name,$set_user_name,$set_password" >> /tmp/secrets_decrypted.txt
        yes | gpg --batch --yes --encrypt --recipient 'eigo.sugiyama0403@gmail.com' --output secrets.gpg /tmp/secrets_decrypted.txt
        rm /tmp/secrets_decrypted.txt
        echo パスワードの追加は成功しました。
        ;;

    "Get Password")
        read -p "サービス名を入力してください： " get_service_name
        gpg --decrypt --output /tmp/secrets_decrypted.txt secrets.gpg 

        # 合致するサービス名の行を検索して表示
        while IFS=, read -r name user password; do
            if [ "$name" == "$get_service_name" ]; then
                answer="Service Name: $name\nUser Name: $user\nPassword: $password"
                break
            fi
        done < /tmp/secrets_decrypted.txt
        # 一時ファイルの削除
        rm /tmp/secrets_decrypted.txt
        if [ "$answer" == "" ]; then
            echo "指定されたサービスの情報は見つかりませんでした。"
        else
            echo -e "$answer"
        fi
        ;;

    "Exit")
        break
        ;;

    *)
        "誤入力です。Add Password/Get Password/Exit から番号で入力してください。"
        ;;
esac
done