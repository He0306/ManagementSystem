<template>
  <div>
    <div style="padding: 10px 0">
      <el-input style="width:250px" suffix-icon="el-icon-search" placeholder="请输入名称" v-model="name"
                clearable></el-input>
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
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column prop="id" label="ID" width="120px">
      </el-table-column>
      <el-table-column prop="name" label="名称" >
      </el-table-column>
      <el-table-column label="图标" class-name="fontSize18" align="center" label-class-name="fontSize12">
        <template slot-scope="scope">
          <i :class="scope.row.name"></i>
        </template>
      </el-table-column>
      <el-table-column prop="value" label="内容" >
      </el-table-column>
      <el-table-column prop="type" label="类型" >
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="300">
        <template slot-scope="scope">
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
        <el-form-item label="名称">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="内容">
          <el-input v-model="form.value" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="类型">
          <el-input v-model="form.type" autocomplete="off"></el-input>
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
  name: "Dist",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      name: '',
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
      //分页查询
      load() {
        this.request.get("/dict/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            name: this.name,
          }
        }).then(res => {
          this.tableData = res.data.records
          this.total = res.data.total
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
      //搜索重置按钮
      reset() {
        this.name = ""
        this.load()
      },
      //新增
      save() {
        this.request.post("/dict/save", this.form).then(res => {
          if (res.code === '200') {
            this.$message({
              type: "success",
              message: "保存成功",
              duration: 1000
            })
            this.load()
            this.dialogFormVisible = false
          } else {
            this.$message({
              type: "error",
              message: "保存失败",
              duration: 1000
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
        this.request.delete("/dict/delete/" + id).then(res => {
          if (res.code === '200') {
            this.$message({
              type: "success",
              message: "删除成功",
              duration: 1000
            })
            this.load()
          } else {
            this.$message({
              type: "error",
              message: "删除失败",
              duration: 1000
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
        this.request.post("/dict/delete/batch", ids).then(res => {
          if (res.code === '200') {
            this.$message({
              type: "success",
              message: "批量删除成功",
              duration: 1000
            })
            this.load()
          } else {
            this.$message({
              type: "error",
              message: "批量删除失败",
              duration: 1000
            })
            this.load()
          }
        })
      },
    }
  }
</script>

<style scoped>
.headerBg {
  background: #eee !important;
}

</style>