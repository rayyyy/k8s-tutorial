# Kubernetesのデプロイチュートリアル

## 今回のゴール
Nuxtで作ったアプリケーションを
デプロイするところまでやります。

## nuxt_appをイメージを作ります。
Dockerfileは用意してあるのでそこからビルドしてイメージを作ります。
```bash
docker build -t nuxt_app .
```

```bash
docker images
```

ちなみに実行して確認もできます。

```bash
docker run -it -p 3333:3333 nuxt_app
```

<walkthrough-spotlight-pointer spotlightId="devshell-web-preview-button" text="プレビューをみる">
</walkthrough-spotlight-pointer>
ポートの変更をクリックして3333番を選んでください。
