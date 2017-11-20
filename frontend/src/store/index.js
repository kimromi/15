import Vue from 'vue';
import Vuex from 'vuex';

import task from './task';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    task,
  },
  state: {
    date: ''
  },
  getters: {
    date: state => state.date,
  },
  actions: {
    changeDate({ commit }, date) {
      commit('changeDate', date);
    },
  },
  mutations: {
    changeDate(state, date) {
      state.date = date;
    },
  }
});
