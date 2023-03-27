<template>
  <div>
    <div style="padding: 10px 0">
      <el-input style="width:250px" suffix-icon="el-icon-search" placeholder="请输入文件名称" v-model="name"
                clearable></el-input>
      <el-button style="margin-left: 3px" type="primary" @click="load">搜索</el-button>
      <el-button style="margin-left: 3px" type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 5px 0">
      <el-button type="primary" @click="handleAdd" v-if="user.role === 'ROLE_ADMIN'">新增<i
          class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm style="margin-left: 5px"
                     confirm-button-text='确定'
                     cancel-button-text='取消'
                     icon="el-icon-info"
                     icon-color="red"
                     title="您确定删除吗？"
                     @confirm="deleteBatch"
      >
        <el-button type="danger" slot="reference" v-if="user.role === 'ROLE_ADMIN'">批量删除<i
            class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
    </div>
    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column prop="id" label="ID" width="80">
      </el-table-column>
      <el-table-column prop="name" label="课程名称">
      </el-table-column>
      <el-table-column prop="score" label="学分">
      </el-table-column>
      <el-table-column prop="times" label="课时">
      </el-table-column>
      <el-table-column prop="teacher" label="授课老师">
      </el-table-column>
      <el-table-column label="是否启用">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.state" active-color="#13ce66" inactive-color="#ccc"
                     @change="changeEnable(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="300">
        <template slot-scope="scope">
          <el-button type="primary" @click="selectCourse(scope.row.id)">选课</el-button>
          <el-button type="warning" size="small" @click="handleEdit(scope.row)" v-if="user.role === 'ROLE_ADMIN'">编辑<i
              class="el-icon-edit"></i>
          </el-button>
          <el-popconfirm style="margin-left: 5px"
                         confirm-button-text='确定'
                         cancel-button-text='取消'
                         icon="el-icon-info"
                         icon-color="red"
                         title="您确定删除吗？"
                         @confirm="handleDelete(scope.row.id)"
          >
            <el-button type="danger" size="small" slot="reference" v-if="user.role === 'ROLE_ADMIN'">删除<i
                class="el-icon-remove-outline"></i></el-button>
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
    <!--新增和编辑弹窗-->
    <el-dialog title="课程信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="80px">
        <el-form-item label="名称">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="学分">
          <el-input v-model="form.score" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="课时">
          <el-input v-model="form.times" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="授课老师">
          <el-select clearable v-model="form.teacherId" placeholder="请选择">
            <el-option v-for="item in teachers" :key="item.id" :label="item.nickname" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Course",
  data() {
    return {
      form: {},
      tableData: [],
      name: '',
      multipleSelection: '',
      pageNum: 1,
      pageSize: 5,
      total: 0,
      headerBg: 'headerBg',
      dialogFormVisible: false,
      teachers: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}

    }
  },
  created() {
    this.load()
  },
  methods: {
    selectCourse(courseId) {
      this.request.post("/course/studentCourse/" + courseId + "/" + this.user.id).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "选课成功",
            duration: 1 * 1000
          })
        } else {
          this.$message({
            type: "error",
            message: "选课失败",
            duration: 1 * 1000
          })
        }
      })
    },
    //分页查询
    load() {
      this.request.get("/course/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      });
      this.request.get("/user/role/ROLE_TEACHER").then(res => {
        this.teachers = res.data

      });

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
    //新增
    save() {
      this.request.post("/course", this.form).then(res => {
        if (res.code === '200') {
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
    //搜索重置按钮
    reset() {
      this.name = ""
      this.load()
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
      this.request.delete("/course/" + id).then(res => {
        if (res.code === '200') {
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
        }
      })
    },
    //批量删除 val:数组
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    deleteBatch() {
      let ids = this.multipleSelection.map(v => v.id)
      this.request.post("/course/delete/batch", ids).then(res => {
        if (res.code === '200') {
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
        }
      })
    },
    //是否启用
    changeEnable(row) {
      this.request.post("/course/update", row).then(res => {
        if (res.code === '200') {
          this.$message({
            message: "操作成功",
            type: "success",
            duration: 1 * 1000
          })
        }
      })
    },
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>