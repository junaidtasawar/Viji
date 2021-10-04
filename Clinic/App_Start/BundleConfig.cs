using System.Web;
using System.Web.Optimization;

namespace Clinic
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                            "~/Scripts/js/jquery-1.11.0.min.js",
                            "~/plugins/jQuery/jquery-2.1.4.js",
                            "~/plugins/jQueryGrid/grid-0.5.1.js",
                            "~/plugins/jQueryUIFilter/jquery.uitablefilter.js",
                            "~/plugins/notification/notify.js",
                            "~/plugins/datatables/jquery.dataTables.min.js",
                            "~/plugins/datatables/dataTables.bootstrap.min.js",
                            "~/plugins/jQueryUI/jquery-ui.min.js",
                            "~/plugins/sparkline/jquery.sparkline.min.js",
                            "~/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js",
                            "~/plugins/jvectormap/jquery-jvectormap-world-mill-en.js",
                            "~/plugins/knob/jquery.knob.js",
                            "~/plugins/daterangepicker/daterangepicker.js",
                            "~/plugins/datepicker/bootstrap-datepicker.js",
                            "~/plugins/timepicker/bootstrap-timepicker.js",
                            "~/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js",
                            "~/plugins/slimScroll/jquery.slimscroll.min.js",
                            "~/plugins/fastclick/fastclick.min.js",
                            "~/plugins/jquery_tags/jquery.tagsinput.js",
                            "~/plugins/morris/morris.min.js"
                               ));

            bundles.Add(new ScriptBundle("~/Scripts/jquery").Include(
                "~/Scripts/utility/error.js",
                "~/Scripts/Validation/validation.js",
                "~/Scripts/utility/common.js",
                "~/Scripts/typeahead.bundle.js",
                "~/Scripts/minified/bootstrap.min.js",
                "~/Scripts/minified/raphael-min.js",
                "~/Scripts/minified/moment.min.js",
                "~/Scripts/minified/app.min.js",
                "~/Scripts/dashboard/dashboard.js",
                "~/Scripts/demo.js"
                ));

            //bundles.Add(new StyleBundle("~/Content/themes/base/minified/css").Include(
            //    "~/Content/themes/base/minified/bootstrap.min.css",
            //    "~/Content/themes/base/minified/font-awesome.min.css",
            //    "~/Content/themes/base/minified/ionicons.min.css",
            //    "~/Content/themes/base/minified/AdminLTE.min.css",
            //    "~/Content/themes/base/skins/_all-skins.min.css",
            //    "~/Content/themes/base/hexdots.css",
            //    "~/Content/themes/base/minified/jquery-ui.css"
            //    ));

            bundles.Add(new StyleBundle("~/plugins/css").Include(
                "~/plugins/iCheck/flat/blue.css",
                "~/plugins/jvectormap/jquery-jvectormap-1.2.2.css",
                "~/plugins/datepicker/datepicker3.css",
                "~/plugins/daterangepicker/daterangepicker-bs3.css",
                "~/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css",
                "~/plugins/timepicker/bootstrap-timepicker.css",
                "~/plugins/jQueryGrid/grid-0.5.1.css",
                "~/plugins/jquery_tags/jquery.tagsinput.css",
                "~/"
                ));
        }
    }
}
