namespace :simplegit do

    desc 'Perform a simple git checkout deploy'
    task :deploy do

        on roles :all do
            info "--> Deploy from #{fetch(:simplegit_repo)} on branch #{fetch(:simplegit_branch)}"

            begin
                execute "ls #{fetch(:simplegit_deploy)}/.git"
            rescue
                execute "cd #{fetch(:simplegit_deploy)} && git init"
                execute "cd #{fetch(:simplegit_deploy)} && git remote add origin #{fetch(:simplegit_repo)}"
            end

            info "--> Updating code from remote repository"

            begin
                execute "cd #{fetch(:simplegit_deploy)} && git fetch"
            rescue
                error "Unable to connect to remote repository, check your configuration, and that a valid ssh key exists for remote server."
                exit
            end

            begin
                execute "cd #{fetch(:simplegit_deploy)} && git show-branch #{fetch(:simplegit_branch)} && git checkout #{fetch(:simplegit_branch)} ; git reset --hard origin/#{fetch(:simplegit_branch)}"
            rescue
                execute "cd #{fetch(:simplegit_deploy)} && git checkout -b #{fetch(:simplegit_branch)} origin/#{fetch(:simplegit_branch)} ;"
            end
            execute "git submodule update --init --recursive"
        end
    end

end

namespace :load do

    task :defaults do
        set :simplegit_deploy, ->   { fetch(:deploy_to) }
        set :simplegit_repo, ->     { fetch(:repo_url) }
        set :simplegit_branch, ->   { fetch(:branch) }

    end

end
