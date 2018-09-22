# Kubernetesのデプロイチュートリアル

## 今回のゴール
Nuxtで作ったアプリケーションを
デプロイするところまでやります。

## nuxt_appをイメージを作ります。
Dockerfileは用意してあるのでそこからビルドしてイメージを作ります。
```bash
docker build -t gcr.io/プロジェクトID/nuxt_app .
```

```bash
docker images
```

```bash
docker push gcr.io/プロジェクトID/nuxt_app
```

ちなみに実行して確認もできます。

```bash
docker run -it -p 3333:3333 nuxt_app
```

<walkthrough-spotlight-pointer spotlightId="devshell-web-preview-button" text="プレビューをみる">
</walkthrough-spotlight-pointer>
ポートの変更をクリックして3333番を選んでください。

終わったら Ctrl + C で終了してください。

## Kubernetesのクラスタをつくります。

まずは、GCPのプロジェクトにサーバー紐づけます。
```bash
gcloud config set project プロジェクトID
```

リージョンも指定しておきます。
```bash
gcloud config set compute/zone asia-northeast1-a
```

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