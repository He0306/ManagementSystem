<template>
  <div>
    <div style="padding: 10px 0">
      <el-input style="width:250px" suffix-icon="el-icon-search" placeholder="请输入名称" v-model="username"
                clearable></el-input>
      <el-input style="width:250px;margin-left: 5px" suffix-icon="el-icon-message" placeholder="请输入邮箱"
                v-model="email" clearable></el-input>
      <el-input style="width:250px;margin-left: 5px" suffix-icon="el-icon-position" placeholder="请输入地址"
                v-model="address" clearable></el-input>
      <el-button style="margin-left: 3px" type="primary" @click="load">搜索</el-button>
      <el-button style="margin-left: 3px" type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 5px 0">
      <el-button type="primary" @click="handleAdd">新增<i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm style="margin-left: 5px"
                     confirm-button-text='确定'
                     cancel-button-text='取消'
                     icon="el-icon-info"
                     icon-color="red"
                     title="您确定删除吗？"
                     @confirm="deleteBatch"
      >
        <el-button type="danger" slot="reference">批量删除<i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
      <el-upload action="http://127.0.0.1:8181/user/import" :show-file-list="false" accept="xlsx" :on-success="handleExcelImportSuccess" style="display: inline-block">
      <el-button type="primary" style="margin-left: 5px">导入<i class="el-icon-bottom"></i></el-button>
      </el-upload>
      <el-button type="primary" @click="exp" style="margin-left: 5px">导出<i class="el-icon-top"></i></el-button>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column prop="id" label="ID" width="80">
      </el-table-column>
      <el-table-column prop="username" label="姓名" width="120">
      </el-table-column>
      <el-table-column prop="role" label="角色">
        <template slot-scope="scope">
          <el-tag type="primary" v-if="scope.row.role === 'ROLE_ADMIN'">管理员</el-tag>
          <el-tag type="primary" v-if="scope.row.role === 'ROLE_TEACHER'">老师</el-tag>
          <el-tag type="primary" v-if="scope.row.role === 'ROLE_STUDENT'">学生</el-tag>
          <el-tag type="primary" v-if="scope.row.role === 'ROLE_NORMAL'">普通用户</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="nickname" label="昵称" width="120">
      </el-table-column>
      <el-table-column prop="email" label="邮箱" width="160">
      </el-table-column>
      <el-table-column prop="phone" label="手机号" width="140">
      </el-table-column>
      <el-table-column prop="address" label="地址">
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="300">
        <template slot-scope="scope">
          <el-button type="success" size="small" @click="lookCourse(scope.row.courses)" v-if="scope.row.role === 'ROLE_TEACHER'">查看授课课程<i class="el-icon-view"></i></el-button>
          <el-button type="success" size="small" @click="lookStuCourse(scope.row.stuCourses)" v-if="scope.row.role === 'ROLE_STUDENT'">查看已选课程<i class="el-icon-view"></i></el-button>
          <el-button type="warning" size="small" @click="handleEdit(scope.row)">编辑<i class="el-icon-edit"></i></el-button>
          <el-popconfirm style="margin-left: 5px"
                         confirm-button-text='确定'
                         cancel-button-text='取消'
                         icon="el-icon-info"
                         icon-color="red"
                         title="您确定删除吗？"
                         @confirm="handleDelete(scope.row.id)"
          >
            <el-button type="danger" size="small" slot="reference">删除<i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding-left: 400px;padding-top: 15px">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[5,10,15,20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>
    <!--弹窗-->
    <el-dialog title="用户信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="80px">
        <el-form-item label="姓名">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色">
          <el-select clearable v-model="form.role" placeholder="请选择角色" style="width: 100%">
            <el-option v-for="item in roles" :key="item.name" :label="item.name" :value="item.flag"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="form.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="form.address" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="用户信息" :visible.sync="vis" width="30%">
      <el-table :data="courses" border stripe>
        <el-table-column prop="name" label="课程名称"></el-table-column>
        <el-table-column prop="score" label="学分"></el-table-column>
      </el-table>
    </el-dialog>

    <el-dialog title="用户信息" :visible.sync="stuVis" width="30%">
      <el-table :data="stuCourses" border stripe>
        <el-table-column prop="name" label="课程名称"></el-table-column>
        <el-table-column prop="score" label="学分"></el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import {serverIp} from "../../public/config";

export default {
  name: "User",
  data() {
    return {
      serverIp: serverIp,
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      username: '',
      email: '',
      address: '',
      form: {},
      multipleSelection: [],
      headerBg: 'headerBg',
      dialogFormVisible: false,
      roles: [],
      courses: [],
      vis: false,
      stuCourses: [],
      stuVis: false
    }
  },
  //进入页面刷新数据
  created() {
    //请求分页查询数据
    this.load()
  },
  methods: {
    lookStuCourse(stuCourses) {
      this.stuCourses = stuCourses
      this.stuVis = true
    },
    lookCourse(courses) {
      this.courses = courses
      this.vis = true
    },

      //分页查询
      load() {
        this.request.get("/user/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            username: this.username,
            email: this.email,
            address: this.address
          }
        }).then(res => {
          this.tableData = res.data.records
          this.total = res.data.total
        });

        this.request.get("/role").then(res => {
          this.roles = res.data
        })
      },
      //页数
      handleSizeChange(pageSize) {
        this.pageSize = pageSize
        this.load()
      },
      //页码
      handleCurrentChange(pageNum) {
        this.pageNum = pageNum
        this.load()
      },
      //搜索重置按钮
      reset() {
        this.username = ""
        this.email = ""
        this.address = ""
        this.load()
      },
      //新增
      save() {
        this.request.post("/user", this.form).then(res => {
          if (res.data) {
            this.$message({
              type: "success",
              message: "保存成功",
              duration: 1 * 1000
            })
            this.load()
            this.dialogFormVisible = false
          } else {
            this.$message({
              type: "error",
              message: "保存失败",
              duration: 1 * 1000
            })
          }
        })
      },
      //打开新增弹窗
      handleAdd() {
        this.dialogFormVisible = true
        this.form = {}
      },
      //编辑
      handleEdit(row) {
        this.form = JSON.parse(JSON.stringify(row))  //深拷贝
        this.dialogFormVisible = true
      },
      //根据ID删除
      handleDelete(id) {
        console.log(id)
        this.request.delete("/user/delete/" + id).then(res => {
          if (res.data) {
            this.$message({
              type: "success",
              message: "删除成功",
              duration: 1 * 1000
            })
            this.load()
          } else {
            this.$message({
              type: "error",
              message: "删除失败",
              duration: 1 * 1000
            })
            this.load()
          }
        })
      },
      //批量删除 val:数组
      handleSelectionChange(val) {
        this.multipleSelection = val
      },
      deleteBatch() {
        let ids = this.multipleSelection.map(v => v.id)
        this.request.post("/user/delete/batch", ids).then(res => {
          if (res.data) {
            this.$message({
              type: "success",
              message: "批量删除成功",
              duration: 1 * 1000
            })
            this.load()
          } else {
            this.$message({
              type: "error",
              message: "批量删除失败",
              duration: 1 * 1000
            })
            this.load()
          }
        })
      },
      //导出
      exp() {
        window.open("http://127.0.0.1:8181/user/export")
      },
      //导入
      handleExcelImportSuccess() {
        this.$message.success("上传成功")
        this.load()
      }
    }
  }
</script>

<style scoped>
.headerBg {
  background: #eee !important;
}

</style>