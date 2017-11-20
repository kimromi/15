export default {
  namespaced: false,
  state: {
    tasks: []
  },
  actions: {
    setTasks({ commit }, tasks) {
      commit('setTasks', tasks);
    },
    addTask({ commit }, task) {
      commit('addTask', task);
    },
    deleteTask({ commit }, taskId) {
      commit('deleteTask', taskId);
    },
  },
  getters: {
    tasks: state => state.tasks
  },
  mutations: {
    setTasks(state, tasks) {
      state.tasks = tasks;
    },
    addTask(state, task) {
      state.tasks.push(task);
    },
    deleteTask(state, taskId) {
      state.tasks.some((task, i) => {
        if (task.id == taskId) state.tasks.splice(i, 1);
      });
    },
  }
};
