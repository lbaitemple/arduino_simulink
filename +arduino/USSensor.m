classdef USSensor < matlab.System & coder.ExternalDependency
    % DHTSensor
    % This class will be used to read data from the DHT11 sensor
    % on the Arduino board.
    %
    
    %#codegen
    %#ok<*EMCA>

    properties (Logical, Nontunable)
        useInch = true;
    end
    properties (Nontunable)
        pinNum = 3;
    end
    properties (Hidden)
        % lastPosition - the last position where the sensor was touched
        lastDistance = single(0);
        % simSampleNum - tracks which sample we are on in a simulation
        simSampleNum = single(1);
    end
    methods (Access = protected)
        function setupImpl(~)
            if coder.target('Rtw')% done only for code generation
                % include the header file that defines our C functions
                coder.cinclude('USSensor_wrapper.h')
                % initialize the touch sensor
                coder.ceval('MW_USSensor_Init');                
            end
        end
        function [recordedDistance] = stepImpl(obj)
            recordedDistance = 0.0;
                 
            if coder.target('Rtw')% done only for code generation
                coder.cinclude('USSensor_wrapper.h')
                % get the current position being touched on the sensor
                coder.ceval('MW_USSensor_Setup', obj.pinNum, obj.useInch);
                recordedDistance = coder.ceval('MW_Get_USSensor_Distance');
                % check if we want to remember the last position touched
               
                obj.lastDistance = recordedDistance;
             else
                recordedDistance(1) =40+obj.simSampleNum;
                % obj.simSampleNum = obj.simSampleNum + single(1);
            end
        end
        function releaseImpl(~)
            if coder.target('Rtw')% done only for code generation
                coder.cinclude('USSensor_wrapper.h');
                % free dynamically allocated memory
                coder.ceval('MW_USSensor_Terminate');
            end
        end
    end
    methods (Static)
        function name = getDescriptiveName()
            name = 'USS Sensor';
        end
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        function updateBuildInfo(buildInfo, context)
            % Update the build-time buildInfo
            if context.isCodeGenTarget('rtw')
                blockRoot = getUSSensorRootPath();
                buildInfo.addIncludePaths({[blockRoot, '/include']});
                buildInfo.addIncludeFiles({'uss.h'});
                buildInfo.addSourcePaths({[blockRoot, '/src']});
                buildInfo.addSourceFiles({'uss.cpp',...
                                          'USSensor_wrapper.cpp'});
            end
        end
    end
end