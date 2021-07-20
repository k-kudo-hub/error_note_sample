<template>
  <div class="footer-area">
    <div class="footer-top">
      <div class="footer-left">
        <a href="/" class="footer-site-name">{{ site.name }}</a>
        <p>{{ site.subtitle }}</p>
        <div class="footer-sns-area">
          <a :href="url.lapras" target="_blank" rel="noopener npreferrer">
            <img :src="image.lapras" height="20px" width="20px">
          </a>
          <a :href="url.twitter" target="_blank" rel="noopener noreferrer">
            <img :src="image.twitter" height="20px" width="20px">
          </a>
        </div>
      </div>
      <div class="footer-right">
        <div class="footer-right-start">
          <p>Error Note</p>
          <a href="/terms" target="_blank" rel="noopener noreferrer">利用規約</a>
          <a href="/privacy" target="_blank" rel="noopener noreferrer">プライバシー</a>
          <a href="#">お問い合わせ</a>
        </div>
        <div class="footer-right-end">
          <p>Joint Dev inc.</p>
          <a :href="url.github" target="_blank" rel="noopener noreferrer">Github<i class="fas fa-external-link-alt ml-5"></i></a>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p class="footer-copy">{{ site.copy }}</p>
    </div>
  </div>
</template>
<script>
import LaprasImage from "../../../assets/images/brain.png"
import TwitterImage from "../../../assets/images/twitter.png"
export default {
  data(){
    return {
      image: {
        lapras: LaprasImage,
        twitter: TwitterImage,
      },
      url: {
        lapras: "https://lapras.com/public/GCUQE8M",
        twitter: "https://twitter.com/WAKO_program",
        github: "https://github.com/k-kudo-hub",
      },
      site: {
        name: "Error Note",
        subtitle: "Error will give you a hint.",
        copy: "©️ 2021 Joint Dev Inc."
      }
    }
  }
}
</script>
<style scoped>

</style>
