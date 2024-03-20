sap.ui.define(
    [
        "sap/ui/core/mvc/Controller",
        "sap/ui/model/json/JSONModel"
    ],
    function(BaseController,JSONModel) {
      "use strict";
  
      return BaseController.extend("ns.poui5.controller.App", {
        onExit : function () {
          this.oUIModel.destroy(); // avoid changes on UI elements if this view destroys
          Controller.prototype.onExit.apply(this);
        },
        onInit: function() {
        var oView = this.getView();

          this.oUIModel = new JSONModel({
            oContext : null,
            iMessages : 0
          });
          oView.setModel(this.oUIModel, "ui");
        }
      });
    }
  );
  