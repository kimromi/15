<template>
  <div class="tasks">
    <h1>Tasks</h1>

    <div class="alert alert-warning" role="alert" v-show="error">
      {{ error }}
    </div>

    <form class="form-group" @submit.prevent="add">
      <input type="text" class="form-control" placeholder="Add task" v-model="name">
    </form>

    <ul class="list-group">
      <li class="list-group-item" v-for="task in tasks">
        <div class="clearfix">
          <div class="pull-left">
            {{ task.name }}
          </div>
          <div class="pull-right">
            <i class="fa fa-trash" @click="destroy(task.id)"></i>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
  import ApiClient from '../../lib/api_client'

  export default {
    data: function() {
      return {
        error: null,
        name: null,
        tasks: []
      }
    },
    created: async function() {
      let { data, error } = await ApiClient.tasks();
      if (!error) {
        this.tasks = data;
      } else {
        this.error = error.message
      }
    },
    methods: {
      add: async function() {
        if (this.name) {
          const { data, error } = await ApiClient.createTask({name: this.name})
          if (!error) {
            this.tasks.push(data);
            this.name = '';
            this.error = ''
          } else {
            this.error = error.message
          }
        }
      },
      destroy: async function(id) {
        const { data, error } = await ApiClient.destroyTask(id)
        if (!error) {
          this.tasks.some((task, i) => {
            if (task.id == id) this.tasks.splice(i, 1);
          });
          this.error = ''
        } else {
          this.error = error.message
        }
      }
    }
  };
</script>

<style lang="scss">
</style>
