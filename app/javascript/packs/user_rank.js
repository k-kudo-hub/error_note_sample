import Vue from 'vue'
import User from '../userRank.vue'

document.addEventListener('turbolinks:load', () => {
  const insertTarget = document.getElementById('nav_bar_lang_rank')
  const alreadyInsert = document.getElementById('rank_content')
  if(alreadyInsert) {
    while(alreadyInsert.lastChild){
      alreadyInsert.removeChild(alreadyInsert.lastChild);
    }
  }
  if(insertTarget) {
    const usr = new Vue({
      render: h => h(User)
    }).$mount()
    insertTarget.insertAdjacentElement('afterbegin', usr.$el)
  }
})
