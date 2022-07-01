# This is only a template based on a simple sidebar layout with a leaflet thematic map 

Rfuns::load_pkgs('meteolecco', 'data.table', 'shiny', 'shinyWidgets')

ui <- fluidPage(

    faPlugin,
    tags$head(
        tags$title('Weather data in Lecco, Italy. @2022 datamaps'),
        tags$style("@import url('https://datamaps.uk/assets/datamaps/icons/fontawesome/all.css;')")
    ),
    
    titlePanel('Weather data in Lecco, Italy'),

    sidebarLayout(

        sidebarPanel(
          
            selectInput('cbo_mtc', 'METRIC:', vars.lst),
            selectInput('cbo_mnt', 'MONTH:', month.name, month.name[month(Sys.Date())]),
            
            width = 3
          
        ),
        
        mainPanel( plotOutput('out_plt', height = '800px') )
    
    )
  
)

server <- function(input, output) {

    output$out_plt <- renderPlot({
        facet_metric(which(month.name == input$cbo_mnt), input$cbo_mtc)
    })
  
}

shinyApp(ui = ui, server = server)
