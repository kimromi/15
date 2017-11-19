<template>
  <div class="time-schedule">
    <div class="percentage">
      <div class="progress">
        <div class="progress-bar progress-bar-success" style="width: 35%"></div>
        <div class="progress-bar progress-bar-warning" style="width: 20%"></div>
        <div class="progress-bar progress-bar-danger" style="width: 10%"></div>
      </div>
    </div>

    <div class="row time-table">
      <div class="table-area col-xs-12 col-sm-8">
        <table class="table">
          <tr v-for="hour in hours" :key="hour">
            <td class="hour">{{ hour }} </td>
            <td v-for="minute in minutes" :key="minute" class="enter" @click="select(hour, minute)" :class="cellClass(hour, minute)">
              <span v-if="records[hour + ':' + minute]">{{ records[hour + ':' + minute].task_name }}</span>
              <span v-else>{{ minute }}-{{ parseInt(minute) + 15 }}</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="enter-area col-xs-12 col-sm-4">
        <ul class="list-group tasks">
          <li class="list-group-item task" v-for="task in tasks" :key="task.id" @click="record(task)">
            {{ task.name }}
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex';
  import _ from 'underscore';
  import ApiClient from '../../../lib/api_client';

  export default {
    data: function() {
      return {
        hours: _.range(0, 24),
        minutes: ['00', '15', '30', '45'],
        records: {},
        selected: null,
        tasks: []
      };
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
      dateChanged: async function() {
        await this.fetchRecords();
      },
      fetchTasks: async function() {
        const { tasks, error } = await ApiClient.tasks();
        if (!error) {
          this.tasks = tasks;
        } else {
          this.error = error.message;
        }
      },
      fetchRecords: async function() {
        const { records, error } = await ApiClient.records(this.date);
        if (!error) {
          for (const record of records) {
            this.records = Object.assign({}, this.records, { [record.time]: record });
          }
        } else {
          this.error = error.message;
        }
      },
      time: function(hour, minute) {
        return `${hour}:${minute}`;
      },
      select: function(hour, minute) {
        this.selected = this.time(hour, minute);
      },
      cellClass: function(hour, minute) {
        const time = this.time(hour, minute);
        return {
          active: this.selected == time,
          yet: !this.records[time],
          recorded: !!this.records[time]
        };
      },
      record: async function(task) {
        if (this.selected) {
          this.records = Object.assign({}, this.records, { [this.selected]: {task_name: task.name}});
          const { error } = await ApiClient.createRecord(this.date, this.selected, task.name);
          if (error) {
            this.error = error.message;
          }
        }
      }
    }
  };
</script>

<style lang="scss">
  .time-schedule {
    height: 100%;
    padding: 110px 0 30px 0;

    .percentage {
      position: absolute;
      top: 70px;
      left: 0;
      padding: 0 30px 0 230px;
      width: 100%;
    }

    .time-table {
      height: 100%;

      .table-area {
        padding: 0;
        height: 100%;
        overflow-y: auto;

        table {
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
      }
    }

    .enter-area {
      height: 100%;
      overflow-y: auto;

      h2 {
        margin: 0;
      }
    }

    .task {
      cursor: pointer;
    }
  }
</style>
