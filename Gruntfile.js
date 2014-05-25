module.exports = function(grunt) {

  // Grunt configuration
  grunt.initConfig({
      
       embed: {
            options: {
              // Task-specific options go here.      
              threshold: '900KB'
                },
            dist: {
              // Target-specific file lists and/or options go here.
               files: {
                   // output: input
                    'index.html': 'phileas-template.html'
            },
          },
        },
  
    less: {
        development: {
            options: {
            //    paths: ["assets/css"]
        },
        files: {
            "phileas.css": "phileas.less"
        }
    },
        dist: {
            options: {
               // paths: ["dist"],
                cleancss: true,
                modifyVars: {
                    //imgPath: '',
                    bgColor: 'red',
                    headcolor: '#228899',
                    //MyFont: 'ArchivoNarrow',
                    //MyLineHeight: '140%',
                    MyFont: 'Lato', 
                    MyLineHeight: '160%',
                }
            },
            files: {
              "phileas.css": "phileas.less"
                }
        },
            
    },
    uglify: {
            options: {
                // banner: '<%= banner %>'
            },
            dist: {
                src: 'phileas.js',
                dest: 'phileas.min.js'
            }
        },
      concat: {
          options: {
            separator: ';', // permet d'ajouter un point-virgule entre chaque fichier concaténé.
          },
          dist: {
            src: ['jquery.js','marked.js'], // la source
            dest: 'phileas.js' // la destination finale
          }
        },
    copy: {
        dist:{
            expand: false,
            flatten: true,
            src: [ 'index.html', 'fonts/*', '*.t2t', 'logo*.png' ],
            dest: 'dist/'
        }
    },
    watch: {
      scripts: {
        files: '**/*.js', // tous les fichiers JavaScript de n'importe quel dossier
        tasks: ['default']
      },
      styles: {
        files: '**/*.less', // tous les fichiers Less de n'importe quel dossier
        tasks: ['default']
      }
    }
    
    
      })

 // Import du package
    grunt.loadNpmTasks('grunt-contrib-less'); 
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-embed');
    grunt.loadNpmTasks('grunt-contrib-watch');

  // Définition des tâches Grunt
  // Redéfinition de la tâche `default` qui est la tâche lancée dès que vous lancez Grunt sans rien spécifier.
  // Note : ici, nous définissons less comme une tâche à lancer si on lance la tâche `default`.
  grunt.registerTask('default', ['less:dist', 'concat:dist', 'uglify:dist', 'embed:dist', 'copy:dist'])



}
