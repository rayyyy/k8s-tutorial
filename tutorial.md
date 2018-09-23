# Kubernetesのデプロイチュートリアル

## 今回のゴール
Nuxtで作ったアプリケーションを
デプロイするところまでやります。


まずは、GCPのプロジェクトにサーバー紐づけます。
右のアイコンからターミナルにコピーできます。

（日本語入ってるときはうまくいかないので手動でコピーしてください。）
```bash
gcloud config set project プロジェクトID
```

リージョンも指定しておきます。
```bash
gcloud config set compute/zone asia-northeast1-a
```

## nuxt_appをイメージを作ります。
Dockerfileは用意してあるのでそこからビルドしてイメージを作ります。
```bash
docker build -t gcr.io/プロジェクトID/nuxt_app .
```

```bash
docker images
```

Kubernetesの実行時にイメージレジストリからダウンロードする必要があるので
GCPのRegistry Containerというところにプッシュしておきます。
```bash
docker push gcr.io/プロジェクトID/nuxt_app
```

ちなみに実行して確認もできます。

```bash
docker run -it -p 3333:3333 gcr.io/プロジェクトID/nuxt_app
```

<walkthrough-spotlight-pointer spotlightId="devshell-web-preview-button" text="プレビューをみる">
</walkthrough-spotlight-pointer>


ポートの変更をクリックして3333番を選んでください。

終わったら Ctrl + C で終了してください。

## Kubernetesのクラスタをつくります。

GCPのクラスタを作ります。
```bash
gcloud container clusters create tutorial --cluster-version=1.10.6-gke.2 \
--machine-type=n1-standard-1 \
--preemptible \
--num-nodes=1
```
東京リージョンで１番低いスペックのプリエンプティブで一つのnodeで構成しています。

そして作成できたら、認証情報を渡します。
```bash
gcloud container clusters get-credentials tutorial
```

## Kubernetesのserviceをデプロイしてみます。

最初にnuxtで作ったwebアプリをデプロイします。

<walkthrough-editor-open-file filePath="k8s-tutorial/kubernetes/web_app.yaml"
                              text="nuxtのアプリの設定yamlを開く">
</walkthrough-editor-open-file>

下記コマンドでデプロイです。

```bash
kubectl apply -f kubernetes/web_app.yaml
```

作ったアプリに外部からのアクセスを許可します。

<walkthrough-editor-open-file filePath="k8s-tutorial/kubernetes/ingress.yaml"
                              text="ingressのアプリの設定yamlを開く">
</walkthrough-editor-open-file>

下記コマンドでデプロイです。数分かかることもあります。

```bash
kubectl apply -f kubernetes/ingress.yaml
```

そして、できたら下記コマンドで確認します。
```bash
kubectl get ingress
```

グローバルIPアドレスが引かれているのでそこにアクセスしてください。

表示を確認できたらクラスタを削除してください。
料金がかかってしまうので
