<template>
  <div>
    <div style="padding: 10px 0">
      <el-input style="width:250px" suffix-icon="el-icon-search" placeholder="请输入名称" v-model="name"
                clearable></el-input>
      <el-button style="margin-left: 3px" type="primary" @click="load">搜索</el-button>
      <el-button style="margin-left: 3px" type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 5px 0">
      <el-button type="primary" @click="handleAdd(null)">新增<i class="el-icon-circle-plus-outline"></i></el-button>
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

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg" row-key="id" default-expand-all
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column prop="id" label="ID" width="80">
      </el-table-column>
      <el-table-column prop="name" label="名称" >
      </el-table-column>
      <el-table-column prop="path" label="路径" >
      </el-table-column>
      <el-table-column prop="pagePath" label="页面路径" >
      </el-table-column>
      <el-table-column label="图标" class-name="fontSize18" align="center" label-class-name="fontSize12">
        <template slot-scope="scope">
          <i :class="scope.row.icon"></i>
        </template>
      </el-table-column>
      <el-table-column prop="description" label="描述" >
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="300">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click="handleAdd(scope.row.id)" v-if="!scope.row.path">新增子菜单<i class="el-icon-plus"></i></el-button>
          <el-button type="warning" size="small" @click="handleEdit(scope.row)">编辑<i class="el-icon-edit"></i>
          </el-button>
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

    <!--弹窗-->
    <el-dialog title="菜单信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="80px">
        <el-form-item label="名称" >
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="路径" >
          <el-input v-model="form.path" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="页面路径" >
          <el-input v-model="form.pagePath" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="图标" >
          <el-select clearable v-model="form.icon" placeholder="请选择" style="width: 100%">
            <el-option v-for="item in options" :key="item.name" :label="item.name" :value="item.value">
            <i :class="item.value"/>{{item.name}}
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="描述" >
          <el-input v-model="form.description" autocomplete="off"></el-input>
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
  name: "User",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
      name: '',
      form: {},
      multipleSelection: [],
      headerBg: 'headerBg',
      dialogFormVisible: false,
      options: []
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
      this.request.get("/menu", {
        params: {
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data
      });
      //请求图标的数据
      this.request.get("/dict/getAll").then(res => {
        this.options = res.data
      });
    },
    //搜索重置按钮
    reset() {
      this.name = ""
      this.load()
    },
    //新增
    save() {
      this.request.post("/menu/save", this.form).then(res => {
        console.log(res)
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
    //打开新增弹窗
    handleAdd(pid) {
      this.dialogFormVisible = true
      this.form = {}
      if (pid){
        this.form.pid = pid
      }
    },
    //编辑
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))  //深拷贝
      this.dialogFormVisible = true
      //请求图标的数据
      this.request.get("/dict/getAll").then(res => {
        this.options = res.data
      });
    },
    //根据ID删除
    handleDelete(id) {
      console.log(id)
      this.request.delete("/menu/delete/" + id).then(res => {
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
      this.request.post("/menu/delete/batch", ids).then(res => {
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
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}
.fontSize18 {
  font-size: 18px;
}
.fontSize12 {
  font-size: 12px;
}

</style>