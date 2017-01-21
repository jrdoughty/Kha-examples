let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('Sdg');
project.addLibrary('haxe-format-tiled');
project.windowOptions.width = 320;
project.windowOptions.height = 240;
resolve(project);
