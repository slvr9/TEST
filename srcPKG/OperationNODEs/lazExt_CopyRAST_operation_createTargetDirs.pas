unit lazExt_CopyRAST_operation_createTargetDirs;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  lazExt_CopyRAST_node,
  lazExt_CopyRAST_node_ROOT, lazExt_CopyRAST_node_Folder,
  LazFileUtils;

type

 tLazExt_CopyRAST_operation_createTargetDirs=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
  end;

implementation

function tLazExt_CopyRAST_operation_createTargetDirs._getOperationName_:string;
begin
    result:='Create Target Dirs';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_createTargetDirs.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=(node is tCopyRAST_node_Folder);
end;

function tLazExt_CopyRAST_operation_createTargetDirs.doOperation(const Node:tCopyRAST_node):boolean;
begin
    _mssge_:=Node.Get_Target_fullName;
     result:=NOT DirPathExists(_mssge_);
     if result then begin
         result:=ForceDirectory(_mssge_);
         if result
         then _mssge_:='TARGET_Path "'+_mssge_+'" CREATED'
         else _mssge_:='ForceDirectory("'+_mssge_+'") ERR';
     end
     else begin
         result:=TRUE;
        _mssge_:='TARGET_Path "'+_mssge_+'" already present';
     end;
end;

end.

