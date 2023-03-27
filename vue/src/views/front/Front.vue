<template>
  <div>
<!--  头部  -->
    <div style="display: flex;height: 60px;line-height: 60px;border-bottom: 1px solid #eee">
    <div style="width: 300px;display: flex;padding-left: 30px">
      <div style="width: 60px">
      <img src="../../assets/01.jpg" style="width: 50px;position: relative;top: 5px;right: 0">
    </div>
      <div style="flex: 1">欢迎来到xx系统</div>
    </div>
    <div style="flex: 1">
<!--   菜单   -->
<!--      <ul style="list-style: none;background-color: #90EE90;">
        <li class="item">
          <el-dropdown>
            <span>更多菜单<i class="el-icon-arrow-down el-icon&#45;&#45;right"></i></span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item icon="el-icon-plus">黄金糕</el-dropdown-item>
              <el-dropdown-item>狮子头</el-dropdown-item>
              <el-dropdown-item>螺蛳粉</el-dropdown-item>
              <el-dropdown-item>双皮奶</el-dropdown-item>
              <el-dropdown-item>蚵仔煎</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </li>
        <li class="item"><a href="/">菜单2</a></li>
        <li class="item"><a href="/">菜单3</a></li>
        <li class="item"><a href="/">菜单4</a></li>
      </ul>-->
      <el-menu :default-active="'1'" class="el-menu-demo" mode="horizontal" router >
        <el-menu-item index="/front/home">首页</el-menu-item>
        <el-menu-item index="/front/video">视频播放</el-menu-item>
        <el-menu-item index="/front/article">文章列表</el-menu-item>
        <el-submenu index="2">
          <template slot="title">我的工作台</template>
          <el-menu-item index="/front/item1">选项1</el-menu-item>
          <el-menu-item index="2-2">选项2</el-menu-item>
          <el-menu-item index="2-3">选项3</el-menu-item>
          <el-submenu index="2-4">
            <template slot="title">选项4</template>
            <el-menu-item index="2-4-1">选项1</el-menu-item>
            <el-menu-item index="2-4-2">选项2</el-menu-item>
            <el-menu-item index="2-4-3">选项3</el-menu-item>
          </el-submenu>
        </el-submenu>
        <el-menu-item index="3" disabled>消息中心</el-menu-item>
        <el-menu-item index="4"><a href="https://www.ele.me" target="_blank">订单管理</a></el-menu-item>
      </el-menu>
    </div>
    <div style="width: 200px">
      <div v-if="!user.username" style="text-align: right;padding-right: 30px">
        <el-button @click="$router.push('/login')">登录</el-button>
        <el-button @click="$router.push('/logout')">注册</el-button>
      </div>
      <div v-else>
        <el-dropdown style="width: 100px; cursor: pointer">
          <div style="display: inline-block">
            <img :src="user.avatar" alt="" style="width: 30px;border-radius: 50%;position: relative;top: 10px;right: 5px">
            <span>{{ user.nickname }}</span><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
          </div>
          <el-dropdown-menu slot="dropdown" style="width: 100px; text-align: center">
            <el-dropdown-item style="font-size: 14px; padding: 5px 0">
              <span style="text-decoration: none" @click="$router.push('/person')">个人信息</span>
            </el-dropdown-item>
            <el-dropdown-item style="font-size: 14px; padding: 5px 0">
              <span style="text-decoration: none" @click="$router.push('/updatePwd')">修改密码</span>
            </el-dropdown-item>
            <el-dropdown-item style="font-size: 14px; padding: 5px 0">
              <span style="text-decoration: none" @click="logout">注销</span>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
    </div>

    <div style="width: 1000px;margin: 0 auto">
      <router-view/>
    </div>

  </div>
</template>

<script>
export default {
  name: "Front",
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {

  },
  methods: {
    logout() {
      this.$store.commit("logout")
      this.$message({
        message: '注销成功',
        type: 'success',
        duration: 1000
      })
    },
  }
}
</script>

<style>
.item{
  display: inline-block;
  width: 100px;
  color: #1E90FF;
  text-align: center;
  cursor: pointer;
}
.item a {
  color: #1E90FF;
  text-decoration: none;
}
.item:hover{
  background-color: pink;
}
</style>