import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import App from './components/app.vue';
import Team from './components/contents/team.vue';
import Me from './components/contents/me.vue';

const router = new VueRouter({
  routes: [
    {
      path: '/', component: App, children: [
        { path: 'team', component: Team },
        { path: 'members/me', component: Me },
      ]
    }
  ]
});
export default router;

