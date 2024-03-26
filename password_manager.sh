#step2
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
        echo $set_user_name > $set_service_name.txt
        echo $set_password >> $set_service_name.txt
        echo パスワードの追加は成功しました。
        ;;
    "Get Password")
        read -p "サービス名を入力してください： " get_service_name
        if [[ -f "$get_service_name.txt" ]]; then
                echo "ユーザー名とパスワードは以下の通りです："
                cat "$get_service_name.txt"
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




