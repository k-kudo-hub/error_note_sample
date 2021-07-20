import Vue from 'vue';
import Router from 'vue-router';
import LogsIndex from '../components/logs/Index.vue';
import LogsShow from '../components/logs/Show.vue';
import UsersShow from '../components/users/Show.vue';

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    { 
      path: '/', 
      component: LogsIndex,
      name: 'logs-index',
    },
    {
      path: '/users/:user_id/logs/:log_id',
      component: LogsShow,
      name: 'logs-show',
    },
    {
      path: '/users/:user_id',
      component: UsersShow,
      name: 'users-show',
    }
  ]
});
