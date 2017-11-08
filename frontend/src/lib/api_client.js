import axios from 'axios';

export default class ApiClient {
  static async currentTeam() {
    return this.format(await this.client().get('api/v1/team'));
  }

  static async teams() {
    return this.format(await this.client().get('api/v1/teams'));
  }

  static async tasks() {
    return this.format(await this.client().get('api/v1/tasks'));
  }

  static async createTask(params) {
    return this.format(await this.client().post('api/v1/tasks', {task: params}));
  }

  static async destroyTask(id) {
    return this.format(await this.client().delete(`api/v1/tasks/${id}`));
  }

  static client() {
    const client = axios.create();
    client.interceptors.response.use((response) => {
      return Promise.resolve({
        data: response.data
      });
    }, (error) => {
      return Promise.resolve({
        error: {
          status: error.response.status,
          message: error.response.data.message
        }
      });
    });
    return client;
  }

  static format(response) {
    return { data: response.data, error: response.error };
  }
}
