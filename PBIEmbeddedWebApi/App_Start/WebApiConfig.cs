using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web.Http;
using Microsoft.Owin.Security.OAuth;
using Newtonsoft.Json.Serialization;

namespace PBIEmbeddedWebApi
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services
            // Configure Web API to use only bearer token authentication.
            config.SuppressDefaultHostAuthentication();
            config.Filters.Add(new HostAuthenticationFilter(OAuthDefaults.AuthenticationType));

            // Web API routes
            config.MapHttpAttributeRoutes();

            /**ADDED MK** - route for call to get list of all reports in Workspace identified 
                             in web.config through WorkspaceCollection and WorkspaceId*/
            config.Routes.MapHttpRoute(
                name: "GetAllReports",
                routeTemplate: "api/{controller}",
                defaults: new { action = "GetAllReports" } );

            /**ADDED MK** - route for call to get metadata of report from 
                            WorkspaceCollection/WorkspaceId identified by ReportID*/
            config.Routes.MapHttpRoute(
                name: "GetReportById",
                routeTemplate: "api/{controller}/{rid}",
                defaults: new { action = "GetReportById", rid = RouteParameter.Optional });

            /**ADDED MK** - route for call to get report from WorkspaceCollection/WorkspaceId 
               identified by ReportID,username and all roles*/
            config.Routes.MapHttpRoute(
                name: "GetReportByIdUsername",
                routeTemplate: "api/{controller}/{rid}/{username}",
                defaults: new { action = "GetReportByIdUsername", rid = RouteParameter.Optional, username = RouteParameter.Optional });

            /**ADDED MK** - route for call to get report from WorkspaceCollection/WorkspaceId 
               identified by ReportID,username and named roles*/
            config.Routes.MapHttpRoute(
                name: "GetReportByIdUsernameRoles",
                routeTemplate: "api/{controller}/{rid}/{username}/{roles}",
                defaults: new { action = "GetReportByIdUsernameRoles", rid = RouteParameter.Optional, username = RouteParameter.Optional, roles = RouteParameter.Optional });

        }
    }
}
