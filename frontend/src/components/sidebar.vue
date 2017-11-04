<template>
  <div class="wrapper">
    <nav class="navbar navbar-inverse navbar-fixed-top sidebar-wrapper" role="navigation">
      <ul class="sidebar-nav">
        <li class="sidebar-brand">
          <router-link to="/">
            <img src="/assets/15-logo.png"/>
          </router-link>
        </li>
        <li>
          <router-link to="/">
            <i class="fa fa-pencil-square-o"></i> Edit
          </router-link>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-cog"></i> Settings <span class="caret"></span>
          </a>
          <ul class="dropdown-menu" role="menu">
            <li>
              <router-link to="/team">
                <i class="fa fa-users"></i> Team
              </router-link>
            </li>
            <li>
              <router-link to="/members/me">
                <i class="fa fa-user"></i> Me
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
  export default {};
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
        padding-top: 15px;
        height: 100px;
        font-size: 20px;
        line-height: 44px;
        color: #FFF;

        a {
          img {
            width: 80px;
          }
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
