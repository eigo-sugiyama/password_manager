#step3
echo パスワードマネージャーへようこそ！
echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
select input in "Add Password" "Get Password" "Exit"
do
case "$input" in
    "Add Password")
        echo パスワードマネージャーへようこそ！
        echo
        read -p "サービス名を入力してください： " set_service_name
        read -p "ユーザー名を入力してください： " set_user_name
        #パスワードを表示させたくなければ、-pオプション
        #read -s -p "パスワードを入力してください： " set_password
        read -p "パスワードを入力してください： " set_password
        echo -e "ユーザー名: $set_user_name\nパスワード: $set_password" | gpg --encrypt --recipient 'eigo.sugiyama0403@gmail.com' --output "${set_service_name}.gpg"
        echo パスワードの追加は成功しました。
        ;;
    "Get Password")
        read -p "サービス名を入力してください： " get_service_name
        if [[ -f "$get_service_name.gpg" ]]; then
                echo "ユーザー名とパスワードは以下の通りです："
                gpg --decrypt "$get_service_name.gpg"
        else
            echo "指定されたサービスの情報は見つかりませんでした。"
        fi
        ;;
    "Exit")
        break
        ;;
    *)
        入力が間違えています。Add Password/Get Password/Exit から入力してください。
    ;;
esac
done