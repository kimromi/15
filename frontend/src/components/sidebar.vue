<template>
  <div class="wrapper">
    <nav class="navbar navbar-inverse navbar-fixed-top sidebar-wrapper" role="navigation">
      <ul class="sidebar-nav">
        <li class="sidebar-brand">
          <img src="/assets/15-logo.png"/>
        </li>
        <li class="sidebar-team">
          <div v-if="Object.keys(currentTeam).length === 0" class="sidebar-team__wait">
            <i class="fa fa-spinner fa-spin"></i>
          </div>
          <div v-else class="sidebar-team__name">
            {{ currentTeam.name }}
          </div>
        </li>
        <li>
          <router-link to="/daily">
            <i class="fa fa-calendar"></i> Today
          </router-link>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-bar-chart"></i> Reports <span class="caret"></span>
          </a>
          <ul class="dropdown-menu" role="menu">
            <li>
              <router-link to="/reports/me">
                <i class="fa fa-user"></i> Me
              </router-link>
            </li>
            <li>
              <router-link to="/reports/team">
                <i class="fa fa-users"></i> Team
              </router-link>
            </li>
          </ul>
        </li>
        <li>
          <router-link to="/tasks">
            <i class="fa fa-check-square-o"></i> Tasks
          </router-link>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-cog"></i> Settings <span class="caret"></span>
          </a>
          <ul class="dropdown-menu" role="menu">
            <li>
              <router-link to="/members/me">
                <i class="fa fa-user"></i> Me
              </router-link>
            </li>
            <li>
              <router-link to="/team">
                <i class="fa fa-users"></i> Team
              </router-link>
            </li>
            <li>
              <a href="/signout">
                <i class="fa fa-sign-out"></i> Sign out
              </a>
            </li>
          </ul>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
  import ApiClient from '../lib/api_client';

  export default {
    mounted: function() {
      this.fetchCurrentTeam();
    },
    data: function() {
      return {
        currentTeam: {},
      };
    },
    methods: {
      fetchCurrentTeam: async function() {
        const { currentTeam, error } = await ApiClient.currentTeam();
        if (!error) {
          this.currentTeam = currentTeam;
          this.selectedTeam = currentTeam.name;
        }
      }
    }
  };
</script>

<style lang="scss">
.wrapper {
  padding-left: 0;

  .sidebar-wrapper {
    left: 200px;
    width: 200px;
    height: 100%;
    margin-left: -200px;
    overflow-y: auto;
    overflow-x: hidden;
    background: #1a1a1a;

    .sidebar-nav {
      position: absolute;
      top: 0;
      width: 200px;
      margin: 0;
      padding: 0;
      list-style: none;

      .sidebar-brand {
        text-align: center;
        padding: 25px 0px;
        height: 110px;
        font-size: 20px;
        line-height: 44px;
        color: #FFF;

        img {
          width: 80px;
        }
      }

      .sidebar-team {
        padding: 0px 15px 10px 15px;

        .sidebar-team__wait {
          text-align: center;
          font-size: 14px;
          line-height: 34px;
        }

        .sidebar-team__name {
          text-align: center;
          padding: 5px 0;
          font-size: 18px;
          line-height: 34px;
          color: #FFF;
          border-bottom: 1px solid #EEE;
          text-transform: uppercase;
        }

      }

      li {
        position: relative;
        line-height: 20px;
        display: inline-block;
        width: 100%;

        a {
          display: block;
          color: #BBB;
          text-decoration: none;
          padding: 10px 15px 10px 30px;

          &:hover, &:active, &:focus {
            color: #FFF;
            text-decoration: none;
            background-color: #1A1A1A;
          }
        }
      }

      li.open {
        a {
          &:hover, &:active, &:focus {
            color: #FFF;
            text-decoration: none;
            background-color: #1A1A1A;
          }
        }
      }

      .dropdown-menu {
          position: relative;
          width: 100%;
          padding: 0;
          margin: 0;
          border-radius: 0;
          border: none;
          background-color: #222;
          box-shadow: none;
      }
    }
  }
}
</style>
