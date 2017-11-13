<template>
  <div class="row time_schedule">
    <div class="col-xs-12 col-sm-8">
      <table class="time-table table">
        <tr v-for="hour in hours">
          <td class="hour">{{ hour }} </td>
          <td v-for="minute in minutes" class="enter yet" @click="select(hour, minute)" :class="{ active: isActive(hour, minute), recorded: records[hour + ':' + minute] }">
            <span v-if="records[hour + ':' + minute]">{{ records[hour + ':' + minute]['name'] }}</span>
            <span v-else>{{ minute }}-{{ parseInt(minute) + 15 }}</span>
          </td>
        </tr>
      </table>
    </div>
    <div class="col-xs-12 col-sm-4 enter-area">
      <ul class="list-group tasks">
        <li class="list-group-item task" v-for="task in tasks" @click="record(task)">
          {{ task.name }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import _ from 'underscore';
  import ApiClient from '../../../lib/api_client'

  export default {
    data: function() {
      return {
        hours: _.range(0, 24),
        minutes: ['00', '15', '30', '45'],
        records: {
          '0:00': {name: 'test1'},
          '0:15': {name: 'test2'},
          '0:30': null,
          '0:45': null,
          '1:00': null,
          '1:15': null,
          '1:30': null,
          '1:45': null,
        },
        selected: null,
        tasks: []
      }
    },
    computed: {
      ...mapGetters(['date'])
    },
    created: function() {
      this.initialize();
      this.dateChanged();
    },
    watch: {
      date: 'dateChanged'
    },
    methods: {
      initialize: function() {
        this.fetchTasks();
      },
      dateChanged: function() {
        this.fetchRecords();
      },
      fetchTasks: async function() {
        const { tasks, error } = await ApiClient.tasks();
        if (!error) {
          this.tasks = tasks;
        } else {
          this.error = error.message
        }
      },
      fetchRecords: async function() {
        const { records, error } = await ApiClient.records(this.date);
        if (!error) {
          //this.records = records;
        } else {
          this.error = error.message
        }
      },
      select: function(hour, minute) {
        this.selected = `${hour}:${minute}`;
      },
      isActive: function(hour, minute) {
        return this.selected == `${hour}:${minute}`
      },
      record: async function(task) {
        if (this.selected) {
          this.records[this.selected] = task;
          const { data, error } = await ApiClient.createRecord(this.date, this.selected, task.name);
        }
      }
    }
  };
</script>

<style lang="scss">
  .time_schedule {
    height: 100%;
    padding: 110px 0 30px 0;

    > div {
      height: 100%;
      padding: 0;
      overflow-y: auto;
    }

    .time-table {
      width: 100%;

      tr {
        td {
          padding: 5px;
          font-size: 13px;
          cursor: pointer;
        }

        td.hour {
          width: 4%;
          text-align: right;
        }

        td.enter {
          width: 24%;
          text-align: center;
        }

        td.yet {
          color: #CCC;
          border: 1px dotted #BBB;
        }
        td.active {
          color: #FFF;
          background-color: #333;
          border: 1px solid #333;
        }
        td.recorded {
          color: #000;
          background-color: #DDD;
          border: 1px solid #CCC;
          font-weight: bold;
        }
      }
    }

    .enter-area {
      padding: 0 15px;

      h2 {
        margin: 0;
      }
    }

    .task {
      cursor: pointer;
    }
  }
</style>
