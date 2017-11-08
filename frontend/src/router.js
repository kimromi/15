import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import App from './components/app.vue';
import Daily from './components/contents/daily.vue';
import Tasks from './components/contents/tasks.vue';
import Team from './components/contents/team.vue';
import Me from './components/contents/me.vue';

const router = new VueRouter({
  routes: [
    {
      path: '/', component: App, children: [
        { path: 'tasks', component: Tasks },
        { path: 'team', component: Team },
        { path: 'members/me', component: Me },
        { path: '', component: Daily, name: 'today' },
        { path: ':date', component: Daily, name: 'daily' },
      ]
    }
  ]
});
export default router;

