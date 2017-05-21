#!/bin/bash

function format_run() {
    cid=$1

    json=$(docker inspect $cid 2>&1)

    # parse container info
    entrypoint=$(  echo $json | jq -r '.[0].Config.Entrypoint | join(" ")'             )
    envvars=$(     echo $json | jq -r '(.[0].Config.Env | [" -e " + .[]] | join(""))'  )
    image=$(       echo $json | jq -r .[0].Image                                       )
    cmd=$(         echo $json | jq -r '.[0].Config.Cmd | join(" ")'                    )
    
    mapped_to_container_temp=`(echo $json| jq '.[0].NetworkSettings .Ports' | jq '.[]'   )`
    
    if [[ "$mapped_to_container_temp" != null ]];
    then
        mapped_to_container=`(echo $json| jq '.[0].NetworkSettings .Ports' | jq '.[]' | jq '.[]' | jq '.HostPort' | tr -d '"' | cut -f 1- -d\/ --output-delimiter=$'\n' )`
        mapped_to_host=$(echo $json | jq -r '.[0].NetworkSettings.Ports | keys | to_entries |  map(.value) | join(" ")')
        array=(${mapped_to_container// / })
        array2=(${mapped_to_host// / })

        ports_result=()

        for i in "${!array[@]}"
        do
            for b in "${!array2[@]}"
            do
              if [[ "$i" == "$b" ]];
              then
                port_map=`(echo "-p ${array[i]}:${array2[b]}")`
                ports_result+=($port_map)
              fi
             done
        done
        echo "docker run --entrypoint $entrypoint $envvars ${ports_result[@]} $image $cmd"
    else
        echo "docker run --entrypoint $entrypoint $envvars ${ports_result[@]} $image $cmd"
    fi
}