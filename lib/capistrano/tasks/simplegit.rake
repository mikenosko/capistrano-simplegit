namespace :simplegit do

    desc 'Perform a simple git checkout deploy'
    task :deploy do

        on roles :all do
            info "--> Deploy from #{fetch(:repository)} on branch #{fetch(:branch)}"

            begin
                execute "ls #{fetch(:deploy_to)}/.git"
            rescue
                invoke 'simplegit:prepare'
            end

            info "--> Updating code from remote repository"

            begin
                execute "cd #{fetch(:deploy_to)} && git fetch"
            rescue
                error "Unable to connect to remote repository, check your configuration, and that a valid ssh key exists for remote server."
                exit
            end

            begin
                execute "cd #{fetch(:deploy_to)} && git show-branch #{fetch(:branch)} && git checkout #{fetch(:branch)} ; git reset --hard origin/#{fetch(:branch)}"
            rescue
                execute "cd #{fetch(:deploy_to)} && git checkout -b #{fetch(:branch)} origin/#{fetch(:branch)} ;"
            end
            execute "git submodule update --init --recursive"
        end
    end

    desc 'Performs the initial setup and fetch of the repo'
    task :prepare do
        execute "cd #{fetch(:deploy_to)} && git init"
        execute "cd #{fetch(:deploy_to)} && git remote add origin #{fetch(:repository)}"
    end

end
