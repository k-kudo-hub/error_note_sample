<template>
  <footer class="footer-area">
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
  </footer>
</template>
<script>
import LaprasImage from "../../../assets/images/brain.png"
import TwitterImage from "../../../assets/images/twitter.png"
import site from "../../site-data.js"
export default {
  data(){
    return {
      image: {
        lapras: LaprasImage,
        twitter: TwitterImage,
      },
      url: {
        lapras: site.URL.LAPRAS,
        twitter: site.URL.TWITTER,
        github: site.URL.GITHUB,
      },
      site: {
        name: site.TITLE,
        subtitle: site.SUB_TITLE,
        copy: site.COPY,
      }
    }
  }
}
</script>
<style scoped>

</style>
