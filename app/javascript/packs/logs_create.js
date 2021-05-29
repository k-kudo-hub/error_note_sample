import Vue from 'vue'
import User from '../logsCreate.vue'

document.addEventListener('turbolinks:load', () => {
  const insertTarget = document.getElementById('body')
  const doNotInsert = document.getElementById('sign_in_btn')
  const alreadyInsert = document.getElementById('log_modal')
  if(doNotInsert) {
    return false;
  }
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
