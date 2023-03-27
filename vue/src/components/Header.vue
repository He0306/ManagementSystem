<template>

  <div style="line-height: 60px; display: flex">
    <div style="flex: 1;font-size: 20px">
    <span :class="collapseBtnClass" style="cursor: pointer" @click="collapse">
      <!--    面包屑    -->
      <el-breadcrumb separator="/" style="display: inline-block; margin-left: 10px">
        <el-breadcrumb-item :to="{ path: '/home' }">主页</el-breadcrumb-item>
        <el-breadcrumb-item>{{ currentPathName }}</el-breadcrumb-item>
      </el-breadcrumb>
    </span>
    </div>
    <el-dropdown style="width: 100px; cursor: pointer">
      <div style="display: inline-block">
        <img :src="user.avatar" alt="" style="width: 30px;border-radius: 50%;position: relative;top: 10px;right: 5px">
        <span>{{ user.nickname }}</span><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
      </div>
      <el-dropdown-menu slot="dropdown" style="width: 100px; text-align: center">
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <span style="text-decoration: none" @click="person">个人信息</span>
        </el-dropdown-item>
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <span style="text-decoration: none" @click="updatePwd">修改密码</span>
        </el-dropdown-item>
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <span style="refreshUsertext-decoration: none" @click="logout">注销</span>
        </el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
  </div>
</template>

<script>
export default {
  name: "Header",
  props: {
    collapseBtnClass: String,
    user: Object
  },
  data() {
    return {

    }
  },
  computed: {
    currentPathName() {
      return this.$store.state.currentPathName;　　//需要监听的数据
    }
  },

  methods: {
    collapse(){
      this.$emit("asideCollapse")
    },
    logout() {
      this.request.get("/user/logout",{
        headers:{
            "token":localStorage.getItem("token")
        }
      }).then(res=>{
        this.$store.commit("logout")
        this.$message({
          message: '注销成功',
          type: 'success',
          duration: 1000
        })
      })

    },
    person() {
      this.$router.push("person")
    },
    updatePwd(){
      this.$router.push("updatePwd")
    }
  }
}
</script>

<style scoped>

</style>