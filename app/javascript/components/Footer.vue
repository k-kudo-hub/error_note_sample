<template>
  <div class="footer-area">
    <div class="footer-top">
      <div class="footer-left">
        <a href="/" class="footer-site-name">Error Note</a>
        <p>Error will give you a hint.</p>
        <div class="footer-sns-area">
          <a :href="laprasURL" target="_blank" rel="noopener npreferrer">
            <img src='../../assets/images/brain.png' height="20px" width="20px">
          </a>
          <a :href="twitterURL" target="_blank" rel="noopener noreferrer">
            <img src='../../assets/images/twitter.png' height="20px" width="20px">
          </a>
        </div>
      </div>
      <div class="footer-right">
        <div class="footer-right-start">
          <p>Error Note</p>
          <a href="/terms">利用規約</a>
          <a href="#">お問い合わせ</a>
        </div>
        <div class="footer-right-end">
          <p>Joint Dev inc.</p>
          <a :href="githubURL" target="_blank">Github<i class="fas fa-external-link-alt ml-5"></i></a>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p class="footer-copy">©️ 2021 Joint Dev Inc.</p>
    </div>
  </div>
</template>
<script>
export default {
  data(){
    return {
      laprasURL: "https://lapras.com/public/GCUQE8M",
      twitterURL: "https://twitter.com/WAKO_program",
      githubURL: "https://github.com/k-kudo-hub",
    }
  }
}
</script>
<style scoped>

</style>
