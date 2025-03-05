
import random as rnd
import numpy as np
import gurobipy as gp
from gurobipy import *



def assign_tasks_opt(nr_sensors, nr_fog_nodes, sensors_resources, fog_nodes_resources, fog_nodes_costs):
    # initialize model
    m = gp.Model('MinCostFallDetection')

    # initialize decision variables
    y = m.addMVar(nr_fog_nodes, lb=0, ub=1, vtype=GRB.INTEGER, name='y')
    x = m.addMVar((nr_sensors, nr_fog_nodes), lb=0, ub=1, vtype=GRB.INTEGER, name='x')

    # add constraints
    for i in range(nr_sensors):
        m.addConstr(quicksum(x[i, j] for j in range(nr_fog_nodes)) == 1)

    for j in range(nr_fog_nodes):
        m.addConstr(quicksum(x[i, j] * sensors_resources[i] for i in range(nr_sensors)) <= y[j] * fog_nodes_resources[j])

    obj = quicksum(y[j] * fog_nodes_costs[j] for j in range(nr_fog_nodes))
    m.setObjective(obj, GRB.MINIMIZE)
    m.update()
    m.optimize()
    #for v in m.getVars():
    #    print(f"{v.VarName}={v.X}")

    return m.ObjVal

def assign_tasks(nr_fog_nodes, sensors_resources, fog_nodes_resources, fog_nodes_costs, method):

    if method == "greedy_resources":
        # sort fog nodes in decreasing order and change fog_nodes_costs accordingly
        order = np.argsort(fog_nodes_resources)[::-1]
        fog_nodes_resources = np.sort(fog_nodes_resources)[::-1]
        fog_nodes_costs = [fog_nodes_costs[i] for i in order]
    else:
        # sort fog nodes in decreasing order and change fog_nodes_costs accordingly
        order = np.argsort(fog_nodes_costs)[::-1]
        fog_nodes_costs = np.sort(fog_nodes_costs)[::-1]
        fog_nodes_resources = [fog_nodes_resources[i] for i in order]
        sensors_resources = list(np.sort(sensors_resources)[::-1])
    sensors_resources = list(np.sort(sensors_resources)[::-1])
    flags = [0] * nr_fog_nodes

    nr_used_fog_nodes = 0
    cost = 0

    for fn in range(nr_fog_nodes):
        flag = 0
        fn_resources = fog_nodes_resources[fn]
        sensors_resources_cp = sensors_resources.copy()
        for s in sensors_resources:
            if s <= fn_resources:
                fn_resources -= s
                sensors_resources_cp.remove(s)
                flag = 1
        sensors_resources = sensors_resources_cp.copy()

        fog_nodes_resources[fn] = fn_resources
        if flag and not flags[fn]:
            cost += fog_nodes_costs[fn]
            nr_used_fog_nodes += 1
            flags[fn] = 1

    return nr_used_fog_nodes, cost

if __name__ == '__main__':

    no_sol = 0
    trivial_sol = 0
    nr_sensors = 20
    nr_fog_nodes = 3
    s1 = 1
    s2 = 0
    # create a likely feasible instance (i.e., resources of the fog nodes>= resources required by IoT nodes)
    while s1 > s2:
        sensors_resources = np.random.randint(1, 100, size=nr_sensors).tolist()
        s1 = sum(sensors_resources)
        fog_nodes_resources = np.random.randint(100, 200, size=nr_fog_nodes).tolist()
        s2 = sum(fog_nodes_resources)

    # no solution:
    if no_sol:
        sensors_resources = [100] * nr_sensors
    if trivial_sol:
        sensors_resources = [1] * nr_sensors

    fog_nodes_costs = np.random.randint(1, 10, size=nr_fog_nodes).tolist()
    # fog_nodes_costs = [10000, 1, 1]
    opt = assign_tasks_opt(nr_sensors, nr_fog_nodes, sensors_resources, fog_nodes_resources, fog_nodes_costs)
    [nr_used_fog_nodes, cost] = assign_tasks(nr_fog_nodes, sensors_resources, fog_nodes_resources, fog_nodes_costs, "greedy_resources")
    print("greedy resources:")
    print(nr_used_fog_nodes, cost)
    [nr_used_fog_nodes, cost] = assign_tasks(nr_fog_nodes, sensors_resources, fog_nodes_resources, fog_nodes_costs, "greedy_costs")
    print("greedy costs:")
    print(nr_used_fog_nodes, cost)



