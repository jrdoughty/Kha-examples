let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions.width = 1024;
project.windowOptions.height = 768;
resolve(project);
