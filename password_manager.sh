#step2
echo パスワードマネージャーへようこそ！
echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
select input in "Add Password" "Get Password" "Exit"
case "$input" in
    "Add Password")
        echo パスワードマネージャーへようこそ！
        echo
        read -p "サービス名を入力してください： " set_service_name
        read -p "ユーザー名を入力してください： " set_user_name
        read -s -p "パスワードを入力してください： " set_password
        echo パスワードの追加は成功しました。
        ;;
    "Get Password")
        read -p "サービス名を入力してください： " get_service_name
    ;;
    "Exit"
    break
    ;;
esac




